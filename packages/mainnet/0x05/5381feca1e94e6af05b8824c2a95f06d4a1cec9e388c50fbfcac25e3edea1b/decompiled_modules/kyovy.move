module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy {
    struct KYOVY has drop {
        dummy_field: bool,
    }

    struct Token has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<KYOVY>,
    }

    public(friend) fun burn_tokens(arg0: 0x2::coin::Coin<KYOVY>, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha) {
        0x2::coin::burn<KYOVY>(&mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Token>(arg1, token_bag_index()).treasury, arg0);
    }

    fun init(arg0: KYOVY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KYOVY>(arg0, 9, b"KYOVY", b"KYOVY", b"https://kyovy.com", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KYOVY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYOVY>>(v0, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint_tokens(arg0: address, arg1: u256, arg2: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KYOVY>>(0x2::coin::mint<KYOVY>(&mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Token>(arg2, token_bag_index()).treasury, 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u64(arg1), arg3), arg0);
    }

    entry fun setup(arg0: address, arg1: 0x2::coin::TreasuryCap<KYOVY>, arg2: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg3), 13906834341847105535);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_admin(arg2, arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg2);
        if (!0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::has_value(arg2, token_bag_index())) {
            let v0 = Token{
                id       : 0x2::object::new(arg3),
                treasury : arg1,
            };
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::add_value<Token>(arg2, token_bag_index(), v0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYOVY>>(arg1, arg0);
        };
    }

    fun token_bag_index() : 0x1::string::String {
        0x1::string::utf8(b"kyovy_token")
    }

    // decompiled from Move bytecode v6
}

