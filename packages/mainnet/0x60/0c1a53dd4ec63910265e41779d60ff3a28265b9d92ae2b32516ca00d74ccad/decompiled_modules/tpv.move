module 0x600c1a53dd4ec63910265e41779d60ff3a28265b9d92ae2b32516ca00d74ccad::tpv {
    struct TPV has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPV>(arg0, 6, b"TPV", b"Trump Vance", b"The term \"Trump-Vance\" refers to the 2024 U.S. presidential ticket of former President Donald Trump and his running mate, Ohio Senator J.D. Vance. Trump, a polarizing figure in American politics known for his populist and nationalist approach, chose Vance to appeal to working-class voters, particularly in key Rust Belt states. Vance, who rose to prominence as the author of Hillbilly Elegy, has positioned himself as a conservative populist and supporter of Trumps policies, though he initially opposed Trump in 2016. Their partnership highlights an effort to strengthen Republican appeal among traditional blue-collar voters, adding a mix of populist messaging and conservative values to their campaign strategy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Trump_Vance_b96a87ecc2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPV>>(v1);
    }

    // decompiled from Move bytecode v6
}

