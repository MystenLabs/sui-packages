module 0x7b13821d741dede56f7582f3a786b923023cfeb93bdff154a176a6ddb454a1e3::catwif {
    struct CATWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATWIF>(arg0, 9, b"CATWIF", b"Catwifsui", b"CatwifSui is a fun, quirky token name combining playful cat agility with the innovation of Sui, perfect for a nimble and dynamic digital currency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1811018553736232960/M-3nH6i-.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CATWIF>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATWIF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

