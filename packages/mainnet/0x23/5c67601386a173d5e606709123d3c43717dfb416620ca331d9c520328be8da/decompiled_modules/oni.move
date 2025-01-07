module 0x235c67601386a173d5e606709123d3c43717dfb416620ca331d9c520328be8da::oni {
    struct ONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONI>(arg0, 6, b"ONI", b"Devil Oni", b"In Japanese folklore, Oni are demons or ogres. They are typically large and scary-looking with red or blue skin, horns, and sharp claws. They are known for their strength and love to cause trouble. Sometimes, they are even said to eat people!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731068695994.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

