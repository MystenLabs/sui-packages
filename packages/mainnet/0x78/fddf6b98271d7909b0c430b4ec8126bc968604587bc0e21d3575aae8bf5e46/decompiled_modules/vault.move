module 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::vault {
    struct ProofCoin<phantom T0, phantom T1, phantom T2> has drop {
        dummy_field: bool,
    }

    struct Vault<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        position: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position,
        proof_coin_supply: 0x2::balance::Supply<ProofCoin<T0, T1, T2>>,
        underlying_balance: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>,
    }

    struct Mint has copy, drop {
        amount: u64,
        sender: address,
    }

    struct Burn has copy, drop {
        amount: u64,
        sender: address,
    }

    public fun balance<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.underlying_balance) + 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(&arg0.position)
    }

    public(friend) fun new<T0, T1, T2>(arg0: 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position, arg1: &mut 0x2::tx_context::TxContext) : Vault<T0, T1, T2> {
        let v0 = ProofCoin<T0, T1, T2>{dummy_field: false};
        Vault<T0, T1, T2>{
            id                 : 0x2::object::new(arg1),
            position           : arg0,
            proof_coin_supply  : 0x2::balance::create_supply<ProofCoin<T0, T1, T2>>(v0),
            underlying_balance : 0x2::balance::zero<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(),
        }
    }

    public fun available<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.underlying_balance)
    }

    public(friend) fun borrow_mut_position<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>) : &mut 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position {
        &mut arg0.position
    }

    public fun borrow_position<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : &0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::Position {
        &arg0.position
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>) {
        0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_balance, arg1);
    }

    public(friend) fun migrate<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: &mut Vault<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(&arg0.position) == 0 && total_supply<T0, T1, T2>(arg1) == 0, 2);
        0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg1.underlying_balance, 0x2::balance::withdraw_all<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_balance));
        0x2::transfer::public_transfer<0x2::coin::Coin<ProofCoin<T0, T1, T2>>>(0x2::coin::from_balance<ProofCoin<T0, T1, T2>>(0x2::balance::increase_supply<ProofCoin<T0, T1, T2>>(&mut arg1.proof_coin_supply, 0x2::balance::supply_value<ProofCoin<T0, T1, T2>>(&arg0.proof_coin_supply)), arg2), @0x0);
    }

    public(friend) fun mint_proof_coin<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<ProofCoin<T0, T1, T2>> {
        let v0 = 0x2::balance::supply_value<ProofCoin<T0, T1, T2>>(&arg0.proof_coin_supply);
        let v1 = if (v0 > 0) {
            0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::u64::mul_div(0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg1), v0, 0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.underlying_balance) + 0x943535499ac300765aa930072470e0b515cfd7eebcaa5c43762665eaad9cc6f2::position::value(&arg0.position))
        } else {
            0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg1)
        };
        assert!(v1 > 0, 0);
        let v2 = Mint{
            amount : v1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Mint>(v2);
        0x2::balance::join<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_balance, arg1);
        0x2::balance::increase_supply<ProofCoin<T0, T1, T2>>(&mut arg0.proof_coin_supply, v1)
    }

    public(friend) fun redeem_underlying_coin<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: 0x2::balance::Balance<ProofCoin<T0, T1, T2>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        let v0 = 0x2::balance::value<ProofCoin<T0, T1, T2>>(&arg1);
        let v1 = Burn{
            amount : v0,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<Burn>(v1);
        0x2::balance::decrease_supply<ProofCoin<T0, T1, T2>>(&mut arg0.proof_coin_supply, arg1);
        0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_balance, 0x78fddf6b98271d7909b0c430b4ec8126bc968604587bc0e21d3575aae8bf5e46::u64::mul_div(v0, 0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.underlying_balance), 0x2::balance::supply_value<ProofCoin<T0, T1, T2>>(&arg0.proof_coin_supply)))
    }

    public fun total_supply<T0, T1, T2>(arg0: &Vault<T0, T1, T2>) : u64 {
        0x2::balance::supply_value<ProofCoin<T0, T1, T2>>(&arg0.proof_coin_supply)
    }

    public(friend) fun withdraw<T0, T1, T2>(arg0: &mut Vault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>> {
        assert!(0x2::balance::value<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&arg0.underlying_balance) >= arg1, 1);
        0x2::balance::split<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::pair::LP<T0, T1>>(&mut arg0.underlying_balance, arg1)
    }

    // decompiled from Move bytecode v6
}

