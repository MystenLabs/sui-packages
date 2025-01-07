module 0x9f2658a4899cb6e9f7ad621b4e2c4952059c9aa9a34daa88a6a2368ef7fc046c::malario {
    struct MALARIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MALARIO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MALARIO>(arg0, 6, b"MALARIO", b"Super Malario", b"Once upon a time, in the humid heart of the mosquito kingdom, there was born a legend. Not just any mosquito, mind you, but a mosquito destined for greatness. His name was Super Malario. While other mosquitoes merely spread itchy bumps and inconvenience across the globe, Malario had bigger plans: not only to be a buzz in your ear but also be the biggest buzz the whole crypto world has ever seen. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Unbenannt_8cf72465e2.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MALARIO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MALARIO>>(v1);
    }

    // decompiled from Move bytecode v6
}

