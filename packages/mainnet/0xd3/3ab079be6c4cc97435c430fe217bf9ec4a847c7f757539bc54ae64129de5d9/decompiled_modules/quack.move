module 0xd33ab079be6c4cc97435c430fe217bf9ec4a847c7f757539bc54ae64129de5d9::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUACK>(arg0, 6, b"QUACK", b"QuantumQuack", b"QuantumQuack is here! He is a Superhero Duck who defends the poor and the defenseless! He is here to fight all the villains. Join his telegram so he knows u are not a bad guy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735924777756.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUACK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

