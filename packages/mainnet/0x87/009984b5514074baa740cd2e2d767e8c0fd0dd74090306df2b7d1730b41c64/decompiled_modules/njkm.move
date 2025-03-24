module 0x87009984b5514074baa740cd2e2d767e8c0fd0dd74090306df2b7d1730b41c64::njkm {
    struct NJKM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NJKM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NJKM>(arg0, 9, b"NJKM", b"lkn;n;kl", b"jlnlknlknkklknklknkknlkkknknkn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c2225dfa86ccba8f3771e2348039a5a2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NJKM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NJKM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

