module 0x196f098fb49039480ad30647cfbc3d5403a83856b3d468d722d8fdcd0c9f5736::loplop {
    struct LOPLOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPLOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOPLOP>(arg0, 9, b"lop", b"loplop", b"kkjkjkkjk kjlkj kljk kljk kljj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/8fc4bac7-df44-4fec-b13b-a62f45a44a67.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOPLOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPLOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

