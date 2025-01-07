module 0xd47808faf1b320db70b1bfcc811ebc50de27b58d4582b52c00ced49ae7508d5d::kidtinny {
    struct KIDTINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIDTINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIDTINNY>(arg0, 6, b"KIDTINNY", b"Tinny the RhinoSui", b"Meet Tinny! The newest Baby Rhino in town.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CA_pia_de_Design_sem_nome_3_ec9ed41df3.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIDTINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIDTINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

