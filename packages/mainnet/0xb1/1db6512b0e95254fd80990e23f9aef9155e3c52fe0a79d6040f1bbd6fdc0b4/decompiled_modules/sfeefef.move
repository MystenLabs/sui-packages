module 0xb11db6512b0e95254fd80990e23f9aef9155e3c52fe0a79d6040f1bbd6fdc0b4::sfeefef {
    struct SFEEFEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFEEFEF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFEEFEF>(arg0, 9, b"sfeefef", b"wsdffe", b"efefwfef", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://resizing.flixster.com/-XZAfHZM39UwaGJIFWKAE8fS0ak=/v3/t/assets/p166593_p_v10_as.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SFEEFEF>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFEEFEF>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFEEFEF>>(v1);
    }

    // decompiled from Move bytecode v6
}

