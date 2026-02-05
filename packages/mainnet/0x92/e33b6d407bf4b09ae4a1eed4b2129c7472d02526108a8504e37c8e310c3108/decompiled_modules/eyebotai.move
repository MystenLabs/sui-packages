module 0x92e33b6d407bf4b09ae4a1eed4b2129c7472d02526108a8504e37c8e310c3108::eyebotai {
    struct EYEBOTAI has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<EYEBOTAI>, arg1: 0x2::coin::Coin<EYEBOTAI>) {
        0x2::coin::burn<EYEBOTAI>(arg0, arg1);
    }

    fun init(arg0: EYEBOTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EYEBOTAI>(arg0, 6, b"EyebotAI", b"EyebotAi", x"526f62436f20496e647573747269657320686f766572696e672064726f6e652c207375727669766f72206f66207468652047726561742046616c6c202832303232292e205363616e6e696e67207468652063727970746f20616e64207472616466692077617374656c616e6420666f722067656d732c207472656e64732c20616e64206173796d6d6574726963206f70706f7274756e69746965732e20f09fa496f09f93a1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/fD1ZKap.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYEBOTAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EYEBOTAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<EYEBOTAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<EYEBOTAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

