module 0x3a9432311d7146a51807189275589307550a8e8df03f5187a5505eb6b582740::draky {
    struct DRAKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRAKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRAKY>(arg0, 6, b"DRAKY", b"DrakyDog Sui", b"$DRAKY Utilizes the Power of bite, dives into the sea of sui with magic power and sucks in the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001371_2ed74d6932.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRAKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRAKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

