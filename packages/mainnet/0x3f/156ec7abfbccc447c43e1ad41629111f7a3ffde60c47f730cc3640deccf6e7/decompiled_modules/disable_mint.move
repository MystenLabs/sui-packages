module 0x3f156ec7abfbccc447c43e1ad41629111f7a3ffde60c47f730cc3640deccf6e7::disable_mint {
    public entry fun disable_minting_permanently(arg0: 0x2::coin::TreasuryCap<0x3f156ec7abfbccc447c43e1ad41629111f7a3ffde60c47f730cc3640deccf6e7::swhit::SWHIT>) {
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<0x3f156ec7abfbccc447c43e1ad41629111f7a3ffde60c47f730cc3640deccf6e7::swhit::SWHIT>>(arg0, @0x0);
    }

    // decompiled from Move bytecode v6
}

