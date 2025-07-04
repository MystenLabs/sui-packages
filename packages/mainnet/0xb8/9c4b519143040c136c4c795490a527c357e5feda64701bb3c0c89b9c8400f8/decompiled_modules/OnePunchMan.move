module 0xb89c4b519143040c136c4c795490a527c357e5feda64701bb3c0c89b9c8400f8::OnePunchMan {
    struct ONEPUNCHMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEPUNCHMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONEPUNCHMAN>(arg0, 9, b"ONE", b"OnePunchMan", b"just one punch and you go to heaven. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://kappa-dev.sgp1.cdn.digitaloceanspaces.com/kappa-dev/coins/268be6dc-1e61-4d8e-b0bd-e6ce7b80e931.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEPUNCHMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEPUNCHMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

