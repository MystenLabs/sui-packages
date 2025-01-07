module 0xffe6cd362816273ea4f0f64fa030b511fb67fd14c9d5fb77b33674fe2f20caea::dialog_management {
    struct Dialog has store, key {
        id: 0x2::object::UID,
        creator: address,
        participant: 0x1::option::Option<address>,
        messages: vector<Message>,
    }

    struct Message has drop, store {
        sender: address,
        content: 0x1::string::String,
        timestamp: u64,
    }

    struct UserDialogs has key {
        id: 0x2::object::UID,
        dialogs: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    struct DialogCreated has copy, drop {
        dialog_id: 0x2::object::ID,
        creator: address,
    }

    struct MessageAdded has copy, drop {
        dialog_id: 0x2::object::ID,
        sender: address,
        timestamp: u64,
    }

    public entry fun add_message(arg0: &mut Dialog, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.creator || 0x1::option::contains<address>(&arg0.participant, &v0), 0);
        let v1 = 0x2::tx_context::epoch(arg2);
        let v2 = Message{
            sender    : v0,
            content   : 0x1::string::utf8(arg1),
            timestamp : v1,
        };
        0x1::vector::push_back<Message>(&mut arg0.messages, v2);
        let v3 = MessageAdded{
            dialog_id : 0x2::object::uid_to_inner(&arg0.id),
            sender    : v0,
            timestamp : v1,
        };
        0x2::event::emit<MessageAdded>(v3);
    }

    public entry fun create_dialog(arg0: &mut UserDialogs, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = Dialog{
            id          : 0x2::object::new(arg1),
            creator     : v0,
            participant : 0x1::option::none<address>(),
            messages    : 0x1::vector::empty<Message>(),
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.dialogs, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.dialogs, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.dialogs, v0), v2);
        let v3 = DialogCreated{
            dialog_id : v2,
            creator   : v0,
        };
        0x2::event::emit<DialogCreated>(v3);
        0x2::transfer::share_object<Dialog>(v1);
    }

    public fun get_messages(arg0: &Dialog) : &vector<Message> {
        &arg0.messages
    }

    public fun get_user_dialog_ids(arg0: &UserDialogs, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.dialogs, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        0x2::vec_set::into_keys<0x2::object::ID>(*0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.dialogs, arg1))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UserDialogs{
            id      : 0x2::object::new(arg0),
            dialogs : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<UserDialogs>(v0);
    }

    public entry fun join_dialog(arg0: &mut Dialog, arg1: &mut UserDialogs, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_none<address>(&arg0.participant), 0);
        let v0 = 0x2::tx_context::sender(arg2);
        arg0.participant = 0x1::option::some<address>(v0);
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg1.dialogs, v0)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg1.dialogs, v0, 0x2::vec_set::empty<0x2::object::ID>());
        };
        0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg1.dialogs, v0), 0x2::object::uid_to_inner(&arg0.id));
    }

    // decompiled from Move bytecode v6
}

