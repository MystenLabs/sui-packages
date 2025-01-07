module 0x55c1b486e0de260c2058b60e87f82fece6e2f029b4d3331df5d0a5173008d01::groggocto {
    struct GROGGOCTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GROGGOCTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GROGGOCTO>(arg0, 6, b"GROGGOCTO", b"GROGGO CTO", b"$GROGGOCTO isn`t just a coin; its a tribute to the memes that bring us together. With no association to Matt Furie or Mind viscosity, this project celebrates the beloved frog that has captured hearts worldwide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/43434_bc0bf1cafa.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GROGGOCTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GROGGOCTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

