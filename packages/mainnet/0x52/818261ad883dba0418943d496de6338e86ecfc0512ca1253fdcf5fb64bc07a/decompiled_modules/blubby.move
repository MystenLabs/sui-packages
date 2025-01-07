module 0x52818261ad883dba0418943d496de6338e86ecfc0512ca1253fdcf5fb64bc07a::blubby {
    struct BLUBBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBBY>(arg0, 6, b"BLUBBY", b"Blubby", b"Bubby the sweetest Bubble in the sea!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/resized_sadas_512x512_ca83ab0453.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

