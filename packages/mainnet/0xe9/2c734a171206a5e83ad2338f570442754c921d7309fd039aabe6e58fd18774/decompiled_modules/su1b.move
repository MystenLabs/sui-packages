module 0xe92c734a171206a5e83ad2338f570442754c921d7309fd039aabe6e58fd18774::su1b {
    struct SU1B has drop {
        dummy_field: bool,
    }

    fun init(arg0: SU1B, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SU1B>(arg0, 6, b"SU1B", b"SUIBORG", b"SuiBorg ($SUIB) The Cybernetic Dog of the Sui Blockchain Description: SuiBorg is a cybernetic dog-themed meme coin built on the Sui blockchain. Combining blockchain innovation with meme culture, SuiBorg offers a vibrant ecosystem featuring: Play-to-Earn Gaming: Run, earn, and customize your", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suib_8b78b8bcca.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SU1B>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SU1B>>(v1);
    }

    // decompiled from Move bytecode v6
}

