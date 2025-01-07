module 0xa325a4e8fb6faa58886492d28a3fa8c0b4986cc0d70b755e668cca790204dc4b::temppp {
    struct TEMPPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEMPPP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEMPPP>(arg0, 9, b"TEMPPP", b"MEOEOE", b"aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-fun-7k-dev.nysm.work/api/file-upload/c6103acdc904ea19ea38b2ef5fdf6ebablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEMPPP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEMPPP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

