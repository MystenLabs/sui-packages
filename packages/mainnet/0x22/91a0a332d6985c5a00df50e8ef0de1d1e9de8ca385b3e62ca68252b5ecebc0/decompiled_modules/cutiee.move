module 0x2291a0a332d6985c5a00df50e8ef0de1d1e9de8ca385b3e62ca68252b5ecebc0::cutiee {
    struct CUTIEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUTIEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUTIEE>(arg0, 6, b"CUTIEE", b"Charming Critter Haven On Sui", b"IT'S TIME TO BECOME THE OFFICIAL SUI MASCOT! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/yc_L8_YO_Sc_400x400_da85fcf7ab.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUTIEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUTIEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

