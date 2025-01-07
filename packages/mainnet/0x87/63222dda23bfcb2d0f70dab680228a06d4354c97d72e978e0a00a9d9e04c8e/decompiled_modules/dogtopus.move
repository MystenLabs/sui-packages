module 0x8763222dda23bfcb2d0f70dab680228a06d4354c97d72e978e0a00a9d9e04c8e::dogtopus {
    struct DOGTOPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGTOPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGTOPUS>(arg0, 6, b"DOGTOPUS", b"DOG OCTOPUS", x"416e206f63746f7075732f646f6720687962726964207468617420686173206265656e207365656e206c75726b696e672061726f756e64207468652053554920636861696e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0276_b279065731.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGTOPUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGTOPUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

