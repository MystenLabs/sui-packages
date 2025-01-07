module 0x9ac5e50d0009157ab7972b50465c033ad6b4708fa5a50a8122fb3874183c1ae4::ls {
    struct LS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LS>(arg0, 6, b"LS", b"len sassaman :)", b"len sassaman", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/len_sassaman_83224762fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LS>>(v1);
    }

    // decompiled from Move bytecode v6
}

