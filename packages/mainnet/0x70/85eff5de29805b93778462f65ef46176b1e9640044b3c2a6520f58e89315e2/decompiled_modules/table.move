module 0x7085eff5de29805b93778462f65ef46176b1e9640044b3c2a6520f58e89315e2::table {
    struct TABLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TABLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TABLE>(arg0, 6, b"TABLE", b"TablOnSui", b"Carpentarrer built the most suitable On sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_124437_4d1e0195ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TABLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TABLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

