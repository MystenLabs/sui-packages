module 0x1431e0b87f70b4214dbddf97851299f4abaf99ef735e41916c09c7b30b86b7e3::tdr {
    struct TDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDR>(arg0, 6, b"TDR", b"Trump Dead Redemption", b"United States, 1899. The end of the Wild West era approaches, and sheriffs hunt down the last outlaw gangs. Whoever does not surrender or succumb ends up dead. After everything goes wrong in a robbery in the western town of Blackwater, Donald Trump and the Van der Linde gang are forced to flee.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/trump_dead_redemption_3ac1b3e45d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

