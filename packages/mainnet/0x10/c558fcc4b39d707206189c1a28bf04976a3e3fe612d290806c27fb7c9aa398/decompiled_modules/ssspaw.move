module 0x10c558fcc4b39d707206189c1a28bf04976a3e3fe612d290806c27fb7c9aa398::ssspaw {
    struct SSSPAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSPAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSPAW>(arg0, 6, b"SSSPAW", b"Pawsui", b"PawSui is the scariest and most interesting memecoin on the Sui blockchain! With its signature fierce feline nature, PawSui combines community spirit with a touch of fun. Whether you're a seasoned crypto enthusiast or a curious newcomer, PawSui invites you to unleash the power of ita claws", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012848_c628be4e25.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSPAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSSPAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

