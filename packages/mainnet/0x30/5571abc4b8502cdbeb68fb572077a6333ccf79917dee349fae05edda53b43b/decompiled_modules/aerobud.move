module 0x305571abc4b8502cdbeb68fb572077a6333ccf79917dee349fae05edda53b43b::aerobud {
    struct AEROBUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEROBUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEROBUD>(arg0, 6, b"AEROBUD", b"AEROBUD SUI", b"Helping Animals bi-weekly the help of our non-profits and community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xfad8cb754230dbfd249db0e8eccb5142dd675a0d_3f3ad9cecf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEROBUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEROBUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

