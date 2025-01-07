module 0x2f25a96a385432fcb66c5a8be95886487363736b99f95528cb72ee8b333f02aa::dks {
    struct DKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DKS>(arg0, 6, b"DKS", b"DUCK SUI", b"LETS FLY TO THE MOON WITH THE FIRST DUCK AT SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000178719_d9da151151.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

