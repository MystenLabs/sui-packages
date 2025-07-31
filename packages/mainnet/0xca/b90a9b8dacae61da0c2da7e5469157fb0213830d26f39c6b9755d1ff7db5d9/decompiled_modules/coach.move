module 0xcab90a9b8dacae61da0c2da7e5469157fb0213830d26f39c6b9755d1ff7db5d9::coach {
    struct COACH has drop {
        dummy_field: bool,
    }

    fun init(arg0: COACH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COACH>(arg0, 6, b"COACH", b"Coach Fart Coin", x"434f41434820434f494e0a436f616368206a65657465640a54686520636861727420646965642e0a5468656e20686520676f74206b69636b65642066726f6d205768616c652043686174206d69642d7275672073717565616c2e0a4e6f77206865206973206c75726b696e6720616c746c6573732c207761746368696e6720464152542070756d7020776974686f75742068696d2e0a4a656574732077696c6c20637279207768656e20776520686974207468652062696c6c792e0a436f61636820616c7265616479206469642e200a0a4f6e65206a6565742e20457465726e616c207368616d652e2020416e6369656e7420466172742070726f76657262", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie2luhh7i4ljorqytxu3boi52rwwq2coxsk7ktlltmilcmpm6ikv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COACH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COACH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

