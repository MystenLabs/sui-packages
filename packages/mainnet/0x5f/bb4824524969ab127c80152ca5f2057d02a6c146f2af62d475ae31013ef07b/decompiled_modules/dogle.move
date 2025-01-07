module 0x5fbb4824524969ab127c80152ca5f2057d02a6c146f2af62d475ae31013ef07b::dogle {
    struct DOGLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGLE>(arg0, 6, b"DOGLE", b"Dog Google", x"444f474c45206973206120646f67207468656d656420676f6f676c652c2054686520706f70756c6172697479206f660a646f67732069732067726f77696e6720616e642063727970746f63757272656e63792069732020737472616e6765720a746f207573696e6720646f6720696d6167657320616e642073796d626f6c7320746f206372656174650a776f726b7320616e642070726f6a65637420646576656c6f706d656e7473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039189_ad263426b8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

