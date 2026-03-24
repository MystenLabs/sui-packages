module 0xdb889ed86d8085d39b7957d0759f14dbfc21319e0b2de0d68beae00b54c35aca::st {
    public(friend) fun a1o<T0, T1>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::s2f<T0, T1>(arg0)
    }

    public(friend) fun a8d<T0, T1>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::s2f<T0, T1>(arg0)
    }

    public(friend) fun b3k<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c6s<T0>(arg0, arg1);
    }

    public(friend) fun b9a<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::d7e<T0>(arg0, arg1, arg2)
    }

    public(friend) fun c0r<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w8s<T0>(arg0)
    }

    public(friend) fun c2g(arg0: address) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::l0v(arg0)
    }

    public(friend) fun c8y<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::h7x<T0>(arg0, arg1, arg2)
    }

    public(friend) fun d1l<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::r1e<T0>(arg0);
    }

    public(friend) fun d1o<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j6t<T0>(arg0, arg1)
    }

    public(friend) fun d4c<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::h7x<T0>(arg0, arg1, arg2)
    }

    public(friend) fun d4m<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b3c<T0>(arg0, arg1, arg2)
    }

    public(friend) fun d6k<T0: store + key>(arg0: T0, arg1: address) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::p8f<T0>(arg0, arg1);
    }

    public(friend) fun d8t<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::n2p<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun d9h<T0: store + key>(arg0: T0, arg1: address) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::p8f<T0>(arg0, arg1);
    }

    public(friend) fun d9p<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<T0>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y4s<T0>(arg0, arg1, arg2);
    }

    public(friend) fun e1g<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w1q<T0>(arg0, arg1);
    }

    public(friend) fun e1l<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b3c<T0>(arg0, arg1, arg2)
    }

    public(friend) fun e7t<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::k3m<T0>(arg0, arg1);
    }

    public(friend) fun f0a<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::v3d<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun f1q<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c8j<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun f2p(arg0: &0x2::clock::Clock) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::b7m(arg0)
    }

    public(friend) fun f7g<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::k3m<T0>(arg0, arg1);
    }

    public(friend) fun g1z<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::r1e<T0>(arg0);
    }

    public(friend) fun g2f<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::h7x<T0>(arg0, arg1, arg2)
    }

    public(friend) fun h3h(arg0: &0x2::object::UID) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::e8m(arg0)
    }

    public(friend) fun h6v<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::n2p<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun h7k(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y7f(arg0, arg1, arg2);
    }

    public(friend) fun i2d(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f3w(arg0, arg1, arg2, arg3)
    }

    public(friend) fun i3o(arg0: &0x2::clock::Clock) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::b7m(arg0)
    }

    public(friend) fun j0m<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : bool {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::a3k<T0>(arg0, arg1)
    }

    public(friend) fun j0p<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::x9a<T0>(arg0, arg1, arg2)
    }

    public(friend) fun j4a<T0>() {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j9b<T0>();
    }

    public(friend) fun j4l<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::x9a<T0>(arg0, arg1, arg2)
    }

    public(friend) fun j5p<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j6t<T0>(arg0, arg1)
    }

    public(friend) fun j8c<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::d7e<T0>(arg0, arg1, arg2)
    }

    public(friend) fun k3r<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::g8k<T0>(arg0, arg1);
    }

    public(friend) fun l4d<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : bool {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::a3k<T0>(arg0, arg1)
    }

    public(friend) fun l5d<T0, T1>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::s2f<T0, T1>(arg0)
    }

    public(friend) fun m7m<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w8s<T0>(arg0)
    }

    public(friend) fun m8n<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::x9a<T0>(arg0, arg1, arg2)
    }

    public(friend) fun n3e(arg0: &0x2::clock::Clock) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::b7m(arg0)
    }

    public(friend) fun n8i(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b9x(arg0, arg1, arg2)
    }

    public(friend) fun n9y(arg0: &0x2::object::UID) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::e8m(arg0)
    }

    public(friend) fun o1v(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b9x(arg0, arg1, arg2)
    }

    public(friend) fun o4v<T0>() {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j9b<T0>();
    }

    public(friend) fun p1c<T0>() : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::m4n<T0>()
    }

    public(friend) fun p5h<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j6t<T0>(arg0, arg1)
    }

    public(friend) fun p8e(arg0: address) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::l0v(arg0)
    }

    public(friend) fun p9z<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::r1e<T0>(arg0);
    }

    public(friend) fun q1j<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w8s<T0>(arg0)
    }

    public(friend) fun q2d(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b9x(arg0, arg1, arg2)
    }

    public(friend) fun q4e<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b3c<T0>(arg0, arg1, arg2)
    }

    public(friend) fun r0n<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::g8k<T0>(arg0, arg1);
    }

    public(friend) fun r0o<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::q2w<T0>(arg0)
    }

    public(friend) fun r0t<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::g8k<T0>(arg0, arg1);
    }

    public(friend) fun r2i<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w1q<T0>(arg0, arg1);
    }

    public(friend) fun r2j(arg0: address) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::l0v(arg0)
    }

    public(friend) fun r4e<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<T0>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y4s<T0>(arg0, arg1, arg2);
    }

    public(friend) fun r4n<T0>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::t4k<T0>(arg0)
    }

    public(friend) fun s0n<T0>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::t4k<T0>(arg0)
    }

    public(friend) fun s2t<T0>() {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j9b<T0>();
    }

    public(friend) fun s3d(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y7f(arg0, arg1, arg2);
    }

    public(friend) fun s3u(arg0: &0x2::object::UID) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::e8m(arg0)
    }

    public(friend) fun s6y<T0>() : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::m4n<T0>()
    }

    public(friend) fun t2c<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c8j<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun t2d<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::d7e<T0>(arg0, arg1, arg2)
    }

    public(friend) fun t4w<T0: store + key>(arg0: T0, arg1: address) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::p8f<T0>(arg0, arg1);
    }

    public(friend) fun t7l<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : bool {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::a3k<T0>(arg0, arg1)
    }

    public(friend) fun u2n<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::k3m<T0>(arg0, arg1);
    }

    public(friend) fun u8n<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f5j<T0>(arg0)
    }

    public(friend) fun v0v<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::q2w<T0>(arg0)
    }

    public(friend) fun v7x<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f5j<T0>(arg0)
    }

    public(friend) fun v8m<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c6s<T0>(arg0, arg1);
    }

    public(friend) fun v8z<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::v3d<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun w1e<T0>() : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::m4n<T0>()
    }

    public(friend) fun w1f(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f3w(arg0, arg1, arg2, arg3)
    }

    public(friend) fun w4r<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c6s<T0>(arg0, arg1);
    }

    public(friend) fun w5l<T0>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::t4k<T0>(arg0)
    }

    public(friend) fun w7l(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y7f(arg0, arg1, arg2);
    }

    public(friend) fun w8m<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::v3d<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun x0o<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::n2p<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun x5y<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w1q<T0>(arg0, arg1);
    }

    public(friend) fun y0i<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c8j<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun y8i<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::q2w<T0>(arg0)
    }

    public(friend) fun z2w(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f3w(arg0, arg1, arg2, arg3)
    }

    public(friend) fun z3o<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<T0>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y4s<T0>(arg0, arg1, arg2);
    }

    public(friend) fun z9v<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f5j<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

