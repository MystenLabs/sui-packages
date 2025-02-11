module 0x5f79ef903d8e61735488cc8bba8f08473c0b9afd199c697d0a7f5dcaf44ba8cc::kcc {
    struct KCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCC>(arg0, 9, b"KCC", b"KittyCoin", b"afefwef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p166593_p_v10_as.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KCC>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCC>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

