module 0x8a17521ee753c3b64fe9365155d450bd2a1003091865fb185364157cc5383303::suigo {
    struct SUIGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGO>(arg0, 9, b"SUIGO", b"SUIGO", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIGO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

