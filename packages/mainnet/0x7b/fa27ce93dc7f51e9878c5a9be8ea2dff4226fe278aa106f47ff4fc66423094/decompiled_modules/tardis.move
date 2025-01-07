module 0x7bfa27ce93dc7f51e9878c5a9be8ea2dff4226fe278aa106f47ff4fc66423094::tardis {
    struct TARDIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARDIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARDIS>(arg0, 6, b"Tardis", b"Tardigrades", b"Tardigrades are among the most resilient animals known, with individual species able to survive extreme conditions such as exposure to extreme temperatures, extreme pressures (both high and low), air deprivation, radiation, dehydration, and starvation that would quickly kill most other known forms of life. Tardigrades have survived exposure to outer space. So let's send $Tardis to the  moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/tardigrade_745104c621.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARDIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARDIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

