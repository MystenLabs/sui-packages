module 0xcf9bea335a12d23aca8bcd027085a6cda1a2ed13b4492a4fb46a8a1f47442866::bleb {
    struct BLEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLEB>(arg0, 9, b"BLEB", b"Sui Bleb", b"The most memeable coin in deep sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://movepump.com/_next/image?url=https%3A%2F%2Fapi.movepump.com%2Fuploads%2FKarya_Seni_Tanpa_Judul_55_9abd05cbb8.png&w=640&q=75")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLEB>(&mut v2, 20000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLEB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

