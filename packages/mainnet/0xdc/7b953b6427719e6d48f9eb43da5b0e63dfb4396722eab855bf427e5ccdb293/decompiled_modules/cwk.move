module 0xdc7b953b6427719e6d48f9eb43da5b0e63dfb4396722eab855bf427e5ccdb293::cwk {
    struct CWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWK>(arg0, 6, b"CWK", b"Crab With Knife", b"Crab with knife.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_151022_9d95222163.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

