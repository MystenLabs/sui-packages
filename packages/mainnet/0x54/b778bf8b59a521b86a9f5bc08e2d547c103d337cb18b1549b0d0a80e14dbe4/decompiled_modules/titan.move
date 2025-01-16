module 0x54b778bf8b59a521b86a9f5bc08e2d547c103d337cb18b1549b0d0a80e14dbe4::titan {
    struct TITAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITAN>(arg0, 6, b"TITAN", b"TITAN", b"GAMING | HUB | NETS | GATEWAY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSE1W3IwM8n1A1ar1G_65XmtErBiI4neDQlcw&s"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TITAN>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TITAN>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITAN>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

