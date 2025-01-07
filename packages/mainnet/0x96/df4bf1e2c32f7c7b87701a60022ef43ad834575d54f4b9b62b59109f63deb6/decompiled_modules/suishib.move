module 0x96df4bf1e2c32f7c7b87701a60022ef43ad834575d54f4b9b62b59109f63deb6::suishib {
    struct SUISHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIB>(arg0, 6, b"SUISHIB", b"Sui Shiba", b"Sui shiba is a new generation memecoin that brings the spirit of Shiba to the Sui blockchain in a way youve never seen before! Built for those who dare to dream big and seek excitement in crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_141618_c529b3a3e1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

