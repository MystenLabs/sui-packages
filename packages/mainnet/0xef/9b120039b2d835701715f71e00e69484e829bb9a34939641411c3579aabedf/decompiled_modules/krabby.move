module 0xef9b120039b2d835701715f71e00e69484e829bb9a34939641411c3579aabedf::krabby {
    struct KRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABBY>(arg0, 6, b"KRABBY", b"Krabby On Sui", x"4b72616262792069732061206d656d652d706f77657265642063727970746f63757272656e6379206275696c74206f6e2074686520626c617a696e672d666173742053554920426c6f636b636861696e2c20696e737069726564206279206f6e65206f6620746865206d6f73742069636f6e696320616e6420756e646572726174656420636861726163746572732066726f6d2074686520506f6bc3a96d6f6e20756e6976657273652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5edcmw7zi5bmxxmxsl3xy3iahiax6cll63oel35xlgohq7y657i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KRABBY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

