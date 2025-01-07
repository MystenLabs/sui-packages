module 0x58225430143e65f49419400e002809ac4f08a426c13bd9c861a48c55a22ce673::trumpet {
    struct TRUMPET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPET>(arg0, 6, b"TRUMPET", b"TRUMPET MAN", b"We just launched Trumpet Manthe only cryptocurrency where every time you buy, Trump plays a solo... and claims it's the greatest investment ever. Believe me, nobody blows it like he does!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Rd5s_PF_Ct_400x400_68d9b06da1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPET>>(v1);
    }

    // decompiled from Move bytecode v6
}

