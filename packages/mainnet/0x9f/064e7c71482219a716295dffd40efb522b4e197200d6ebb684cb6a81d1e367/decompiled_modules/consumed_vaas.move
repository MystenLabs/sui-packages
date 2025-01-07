module 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::consumed_vaas {
    struct ConsumedVAAs has store {
        hashes: 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::set::Set<0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::Bytes32>,
    }

    public fun consume(arg0: &mut ConsumedVAAs, arg1: 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::Bytes32) {
        0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::set::add<0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::Bytes32>(&mut arg0.hashes, arg1);
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) : ConsumedVAAs {
        ConsumedVAAs{hashes: 0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::set::new<0x9f064e7c71482219a716295dffd40efb522b4e197200d6ebb684cb6a81d1e367::bytes32::Bytes32>(arg0)}
    }

    // decompiled from Move bytecode v6
}

