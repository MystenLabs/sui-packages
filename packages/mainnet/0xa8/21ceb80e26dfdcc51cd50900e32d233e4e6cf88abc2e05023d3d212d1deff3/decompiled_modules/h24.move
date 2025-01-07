module 0xa821ceb80e26dfdcc51cd50900e32d233e4e6cf88abc2e05023d3d212d1deff3::h24 {
    struct StoryWritter has key {
        id: 0x2::object::UID,
        initial_prompt: 0x1::string::String,
        prompts: vector<0x1::string::String>,
        current_user: address,
        queue: vector<address>,
    }

    public entry fun add_prompt_and_queue(arg0: &mut StoryWritter, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : 0xa821ceb80e26dfdcc51cd50900e32d233e4e6cf88abc2e05023d3d212d1deff3::mint_nft::StoryPartMinted {
        let v0 = 0x2::tx_context::sender(arg3);
        add_to_queue_internal(arg0, v0);
        add_prompt_internal(arg0, arg1, v0);
        0xa821ceb80e26dfdcc51cd50900e32d233e4e6cf88abc2e05023d3d212d1deff3::mint_nft::mint(arg1, arg2, arg3)
    }

    fun add_prompt_internal(arg0: &mut StoryWritter, arg1: 0x1::string::String, arg2: address) {
        assert!(!0x1::string::is_empty(&arg1), 43);
        assert!(arg2 == arg0.current_user, 44);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.prompts, arg1);
        if (0x1::vector::is_empty<address>(&arg0.queue)) {
            arg0.current_user = arg2;
        } else {
            arg0.current_user = 0x1::vector::remove<address>(&mut arg0.queue, 0);
        };
    }

    fun add_to_queue_internal(arg0: &mut StoryWritter, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.queue, &arg1), 42);
        0x1::vector::push_back<address>(&mut arg0.queue, arg1);
    }

    public fun get_all_prompts(arg0: &StoryWritter) : vector<0x1::string::String> {
        arg0.prompts
    }

    public fun get_current_user(arg0: &StoryWritter) : address {
        arg0.current_user
    }

    public fun get_initial_prompt(arg0: &StoryWritter) : 0x1::string::String {
        arg0.initial_prompt
    }

    public fun get_queue(arg0: &StoryWritter) : vector<address> {
        arg0.queue
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StoryWritter{
            id             : 0x2::object::new(arg0),
            initial_prompt : 0x1::string::utf8(b"Once upon in cyber silent hill..."),
            prompts        : 0x1::vector::empty<0x1::string::String>(),
            current_user   : 0x2::tx_context::sender(arg0),
            queue          : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<StoryWritter>(v0);
    }

    // decompiled from Move bytecode v6
}

