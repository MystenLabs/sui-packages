module 0x9a20191413032ddcb00e017f8c11242f565cb796214625909b05325807895182::clc {
    struct CLC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLC>(arg0, 9, b"CLC", b"CoralCash", b"SUUUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLwUvVF8xn_ucFu2CJVBOSEFNZwQiQ4h7kT9qEotDGpSwPK3XyCUvj3jPzX0t6H67L9r4&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLC>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLC>>(v1);
    }

    // decompiled from Move bytecode v6
}

