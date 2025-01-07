module 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::seq {
    struct Seq has copy, drop, store {
        dummy_field: bool,
    }

    public fun borrow_mut(arg0: &mut 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust, arg1: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::TrusteeCap) : &mut 0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::Sequencer {
        let v0 = Seq{dummy_field: false};
        0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::borrow_mut_ref<Seq, 0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::Sequencer>(arg0, arg1, v0)
    }

    public fun add_sequencer(arg0: &mut 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust, arg1: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::SettlorCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Seq{dummy_field: false};
        0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::entrust<Seq, 0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::Sequencer>(arg0, arg1, v0, 0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::create(arg2));
    }

    public fun bos(arg0: &mut 0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::Trust, arg1: &0xb5cf10a904deadf9272fcbdc8100e9e710990b5036a745ba579e9cd002c62d49::trust::TrusteeCap, arg2: u64, arg3: u8) : 0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::Indexer {
        0xc08b55462b9c1aa732f9f36d1f83c4b770353e5aaf54515b7c391e85e5edc29e::sequencer::bos(borrow_mut(arg0, arg1), arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

