module 0x64beb1ba36ad8ddb011c234eda313f8ce378b9bcd1c5f11745b6c05797e8e717::mlyn {
    struct MLYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MLYN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MLYN>(arg0, 9, b"MLYN", b"MULYONO", b"Mulyono is greatest supreme leader in Konoha. With his innocent face, he can unite his clan with Wowo Clan and make Konoha great again.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/63a620c2-f54a-49ff-87b6-cf4c254980d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MLYN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MLYN>>(v1);
    }

    // decompiled from Move bytecode v6
}

