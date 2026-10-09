module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo {
    struct UtxoId has copy, drop, store {
        txid: address,
        vout: u32,
    }

    struct Utxo has copy, drop, store {
        id: UtxoId,
        amount: u64,
        derivation_path: 0x1::option::Option<address>,
    }

    public fun utxo(arg0: UtxoId, arg1: u64, arg2: 0x1::option::Option<address>) : Utxo {
        Utxo{
            id              : arg0,
            amount          : arg1,
            derivation_path : arg2,
        }
    }

    public(friend) fun amount(arg0: &Utxo) : u64 {
        arg0.amount
    }

    public(friend) fun delete(arg0: Utxo) {
        let Utxo {
            id              : _,
            amount          : _,
            derivation_path : _,
        } = arg0;
    }

    public(friend) fun derivation_path(arg0: &Utxo) : 0x1::option::Option<address> {
        arg0.derivation_path
    }

    public(friend) fun id(arg0: &Utxo) : UtxoId {
        arg0.id
    }

    public fun utxo_id(arg0: address, arg1: u32) : UtxoId {
        UtxoId{
            txid : arg0,
            vout : arg1,
        }
    }

    // decompiled from Move bytecode v7
}

