module 0x79bfcf4cdb908e7a25608e09d4495601188a933be8db2befe8e3462d6fb4946d::receipt {
    struct RECEIPT has drop {
        dummy_field: bool,
    }

    struct Receipt has key {
        id: 0x2::object::UID,
        form: 0x2::object::ID,
        submission: 0x2::object::ID,
        title: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    fun init(arg0: RECEIPT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<RECEIPT>(arg0, arg1);
        let v1 = 0x2::display::new<Receipt>(&v0, arg1);
        0x2::display::add<Receipt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{title}"));
        0x2::display::add<Receipt>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Receipt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A sealed submission receipt from Tusk."));
        0x2::display::add<Receipt>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://tusk.wal.app"));
        0x2::display::update_version<Receipt>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Receipt>>(v1, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Receipt{
            id         : 0x2::object::new(arg5),
            form       : arg0,
            submission : arg1,
            title      : arg2,
            image_url  : arg3,
        };
        0x2::transfer::transfer<Receipt>(v0, arg4);
    }

    // decompiled from Move bytecode v7
}

