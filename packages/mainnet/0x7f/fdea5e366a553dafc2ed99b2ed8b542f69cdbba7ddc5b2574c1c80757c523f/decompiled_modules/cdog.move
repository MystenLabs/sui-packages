module 0x7ffdea5e366a553dafc2ed99b2ed8b542f69cdbba7ddc5b2574c1c80757c523f::cdog {
    struct CDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: CDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CDOG>(arg0, 6, b"CDOG", b"cute dog", b"for fun NOT A RUG PULLER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_182010_e5b887abd6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

