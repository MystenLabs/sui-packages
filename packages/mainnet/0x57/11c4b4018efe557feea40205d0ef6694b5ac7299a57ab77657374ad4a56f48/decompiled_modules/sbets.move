module 0x5711c4b4018efe557feea40205d0ef6694b5ac7299a57ab77657374ad4a56f48::sbets {
    struct SBETS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBETS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBETS>(arg0, 9, b"sbets", b"suibets", b"Betting Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/a4d54090-0707-11f0-b264-5f08cd100cd6")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBETS>>(v1);
        0x2::coin::mint_and_transfer<SBETS>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBETS>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

