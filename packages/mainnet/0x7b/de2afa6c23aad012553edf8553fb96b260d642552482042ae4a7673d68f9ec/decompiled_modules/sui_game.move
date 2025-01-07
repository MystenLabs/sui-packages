module 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::sui_game {
    struct SUI_GAME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::GameOwnerCapability<0x2::sui::SUI>>(0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game::new<0x2::sui::SUI, SUI_GAME>(arg0, 100000000, 10000000000, 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::difficulties(), 1000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

