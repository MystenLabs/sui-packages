module 0x37730b4ee262192f138f344bf168cb69c329f27dc07696e5fcf6974b7b972e87::xmas {
    struct XMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMAS>(arg0, 6, b"XMAS", b"Xmas With ELON", b"Almost Christmas time let's get this coin bonded. Once we bond I will create a Telegram, website & X page for our community. Paid dexscreener ads will be coming as well.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734964117440.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XMAS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMAS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

