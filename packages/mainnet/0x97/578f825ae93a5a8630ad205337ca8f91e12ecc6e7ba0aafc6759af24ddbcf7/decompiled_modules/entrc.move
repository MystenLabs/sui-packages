module 0x97578f825ae93a5a8630ad205337ca8f91e12ecc6e7ba0aafc6759af24ddbcf7::entrc {
    struct ENTRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENTRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENTRC>(arg0, 9, b"ENTRC", b"EntraCoin", b"A coin made by entrepreneurs for entrepreneurs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://seniorslifestylemag.com/wp-content/uploads/2017/05/bigstock-Entrepreneurship-Tycoon-Small-148214180-scaled.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ENTRC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENTRC>>(v2, @0xd7dfdbbf2e874f54624c6eeda34f32b8c52f42c39c7d3e7420d3440477f3c80e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENTRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

