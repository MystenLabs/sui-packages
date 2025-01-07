module 0xcc48b1374b6670c97207f85f3de98992491f8a5ba94987cea11f76e4c45075f::suideng {
    struct SUIDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENG>(arg0, 6, b"SUIDENG", b"SUI-DENG", x"5355492d44454e4720697320746865206f6666696369616c20756e6465727761746572206261627920686970706f206f66207468652053554920776f726c64210a0a466f6c6c6f77206f75722073746f72792c20616e642068656c702075732066696e642074686520547265617375692049736c616e642e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_26_072645_21e8c138a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

