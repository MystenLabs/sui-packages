module 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::swheel_game {
    struct SWHEEL_GAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWHEEL_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::GameOwnerCapability<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>>(0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::new<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL, SWHEEL_GAME>(arg0, 1000000000, 1000000000000, 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::difficulties(), 0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

