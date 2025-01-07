module 0xe5df1f250e28dd7fdf718f3783c5d0fd2a4bc4189557b14170a8fcef6cc368fe::tento {
    struct TENTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TENTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TENTO>(arg0, 6, b"TENTO", b"Sui Tento", b"The most resilient turtle on Sui - Tento different  the kemp's ridley sea turtles dip is real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009369_76e74327eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TENTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TENTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

