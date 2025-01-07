module 0x96a1fcd2e3341b3fcee790a48ab3da7ed7b6595be3e235f10a5dc21a0c57f905::simpson {
    struct SIMPSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIMPSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIMPSON>(arg0, 6, b"SIMPSON", b"Sui Simpson", b"Its time to turn your Dohs into Dough!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logonew_2e9cc5a0ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIMPSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIMPSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

