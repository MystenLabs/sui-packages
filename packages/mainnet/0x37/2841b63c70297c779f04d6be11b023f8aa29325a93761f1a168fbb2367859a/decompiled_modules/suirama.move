module 0x372841b63c70297c779f04d6be11b023f8aa29325a93761f1a168fbb2367859a::suirama {
    struct SUIRAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRAMA>(arg0, 9, b"SUIRAMA", b"SUIRAMA", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIRAMA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRAMA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

