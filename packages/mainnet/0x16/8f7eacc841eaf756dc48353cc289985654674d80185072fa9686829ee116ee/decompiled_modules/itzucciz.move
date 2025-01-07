module 0x168f7eacc841eaf756dc48353cc289985654674d80185072fa9686829ee116ee::itzucciz {
    struct ITZUCCIZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: ITZUCCIZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ITZUCCIZ>(arg0, 9, b"itzucciz", b"itzucciz7q", b"gfizc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ITZUCCIZ>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ITZUCCIZ>>(v2, @0xc8c4ef6b64b45ed49b0c258f784ba4a6545bed711e4d900518cfb694ee90547e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ITZUCCIZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

