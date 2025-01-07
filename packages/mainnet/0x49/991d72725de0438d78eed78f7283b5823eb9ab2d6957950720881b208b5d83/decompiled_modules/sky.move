module 0x49991d72725de0438d78eed78f7283b5823eb9ab2d6957950720881b208b5d83::sky {
    struct SKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKY>(arg0, 6, b"SKY", b"Suiky", b"Introducing Suiky the Cosmic Quirka-a playful alien with a vibrant body, three curious eyes, and a contagious smile. Mischievous and full of charm, Suiky lights up the galaxy and is the perfect mascot for the SuikyCoin adventure!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240915165854_52acd75b86.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

