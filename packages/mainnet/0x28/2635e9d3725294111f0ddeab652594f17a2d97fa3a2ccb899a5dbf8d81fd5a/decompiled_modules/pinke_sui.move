module 0x282635e9d3725294111f0ddeab652594f17a2d97fa3a2ccb899a5dbf8d81fd5a::pinke_sui {
    struct PINKE_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PINKE_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PINKE_SUI>(arg0, 6, b"PINKE", b"PINKE", b"Hi, i'm PINKE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://turquoise-worried-tapir-661.mypinata.cloud/ipfs/QmVm3dkdmer5Z5i6vRubSZLK5HuNb2nnW8nU8gZPhBX54A/logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PINKE_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PINKE_SUI>>(0x2::coin::mint<PINKE_SUI>(&mut v2, 10000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PINKE_SUI>>(v2);
    }

    // decompiled from Move bytecode v6
}

