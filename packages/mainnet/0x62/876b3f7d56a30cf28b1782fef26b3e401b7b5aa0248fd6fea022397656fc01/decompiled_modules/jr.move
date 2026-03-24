module 0x62876b3f7d56a30cf28b1782fef26b3e401b7b5aa0248fd6fea022397656fc01::jr {
    public(friend) fun b1b<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b3c<T0>(arg0, arg1, arg2)
    }

    public(friend) fun b1c<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::h7x<T0>(arg0, arg1, arg2)
    }

    public(friend) fun b3h<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w8s<T0>(arg0)
    }

    public(friend) fun b4g<T0: store + key>(arg0: T0, arg1: address) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::p8f<T0>(arg0, arg1);
    }

    public(friend) fun b6y(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y7f(arg0, arg1, arg2);
    }

    public(friend) fun c3e<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j6t<T0>(arg0, arg1)
    }

    public(friend) fun c3s<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : bool {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::a3k<T0>(arg0, arg1)
    }

    public(friend) fun c3y<T0: store + key>(arg0: T0, arg1: address) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::p8f<T0>(arg0, arg1);
    }

    public(friend) fun c4b<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c8j<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun c9p<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c8j<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun d1x(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f3w(arg0, arg1, arg2, arg3)
    }

    public(friend) fun d3n(arg0: &0x2::object::UID) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::e8m(arg0)
    }

    public(friend) fun d3v<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c6s<T0>(arg0, arg1);
    }

    public(friend) fun d5l<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c8j<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public(friend) fun e1r<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : bool {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::a3k<T0>(arg0, arg1)
    }

    public(friend) fun e2c<T0>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::t4k<T0>(arg0)
    }

    public(friend) fun f3v(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b9x(arg0, arg1, arg2)
    }

    public(friend) fun f5n<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::g8k<T0>(arg0, arg1);
    }

    public(friend) fun f6r<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::g8k<T0>(arg0, arg1);
    }

    public(friend) fun g3z<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w1q<T0>(arg0, arg1);
    }

    public(friend) fun g6d<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w8s<T0>(arg0)
    }

    public(friend) fun h1k(arg0: &0x2::clock::Clock) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::b7m(arg0)
    }

    public(friend) fun h2d<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::r1e<T0>(arg0);
    }

    public(friend) fun h3b<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w1q<T0>(arg0, arg1);
    }

    public(friend) fun h3c<T0>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::t4k<T0>(arg0)
    }

    public(friend) fun h4y<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::q2w<T0>(arg0)
    }

    public(friend) fun h7e<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::k3m<T0>(arg0, arg1);
    }

    public(friend) fun i0y<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::h7x<T0>(arg0, arg1, arg2)
    }

    public(friend) fun i3s<T0>() {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j9b<T0>();
    }

    public(friend) fun j1l<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c6s<T0>(arg0, arg1);
    }

    public(friend) fun j1u<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) : bool {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::a3k<T0>(arg0, arg1)
    }

    public(friend) fun j2n(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b9x(arg0, arg1, arg2)
    }

    public(friend) fun j5y<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::r1e<T0>(arg0);
    }

    public(friend) fun j9s<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::v3d<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun k1a(arg0: &0x2::object::UID) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::e8m(arg0)
    }

    public(friend) fun k4n<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w8s<T0>(arg0)
    }

    public(friend) fun k4v(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y7f(arg0, arg1, arg2);
    }

    public(friend) fun k6j(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f3w(arg0, arg1, arg2, arg3)
    }

    public(friend) fun k7u<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::n2p<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun k8t<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::d7e<T0>(arg0, arg1, arg2)
    }

    public(friend) fun l0e<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b3c<T0>(arg0, arg1, arg2)
    }

    public(friend) fun l1h<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::h7x<T0>(arg0, arg1, arg2)
    }

    public(friend) fun l9p<T0>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::t4k<T0>(arg0)
    }

    public(friend) fun m3o<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::v3d<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun m7t<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::n2p<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun m8x<T0>() : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::m4n<T0>()
    }

    public(friend) fun n0i<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::q2w<T0>(arg0)
    }

    public(friend) fun n3t<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::k3m<T0>(arg0, arg1);
    }

    public(friend) fun n6k<T0>() {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j9b<T0>();
    }

    public(friend) fun o5d<T0, T1>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::s2f<T0, T1>(arg0)
    }

    public(friend) fun o8l(arg0: &0x2::object::UID) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::e8m(arg0)
    }

    public(friend) fun p1s(arg0: address) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::l0v(arg0)
    }

    public(friend) fun p2p<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f5j<T0>(arg0)
    }

    public(friend) fun p3e<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j6t<T0>(arg0, arg1)
    }

    public(friend) fun q3h(arg0: address) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::l0v(arg0)
    }

    public(friend) fun q5m<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::x9a<T0>(arg0, arg1, arg2)
    }

    public(friend) fun q6r<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j6t<T0>(arg0, arg1)
    }

    public(friend) fun q7c(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f3w(arg0, arg1, arg2, arg3)
    }

    public(friend) fun q7v<T0>() {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::j9b<T0>();
    }

    public(friend) fun r1f(arg0: &0x2::clock::Clock) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::b7m(arg0)
    }

    public(friend) fun r7o<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::c6s<T0>(arg0, arg1);
    }

    public(friend) fun s6i<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f5j<T0>(arg0)
    }

    public(friend) fun s9f<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b3c<T0>(arg0, arg1, arg2)
    }

    public(friend) fun t1t<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<T0>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y4s<T0>(arg0, arg1, arg2);
    }

    public(friend) fun t4p<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<T0>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y4s<T0>(arg0, arg1, arg2);
    }

    public(friend) fun t5d<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::d7e<T0>(arg0, arg1, arg2)
    }

    public(friend) fun u5b<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::k3m<T0>(arg0, arg1);
    }

    public(friend) fun u9g<T0>(arg0: &0x2::coin::Coin<T0>) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::f5j<T0>(arg0)
    }

    public(friend) fun u9k<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::v3d<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    public(friend) fun v0b<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::g8k<T0>(arg0, arg1);
    }

    public(friend) fun v5s<T0>(arg0: 0x2::coin::Coin<T0>) : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::q2w<T0>(arg0)
    }

    public(friend) fun v6h<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::d7e<T0>(arg0, arg1, arg2)
    }

    public(friend) fun v8g<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::w1q<T0>(arg0, arg1);
    }

    public(friend) fun v9i<T0>(arg0: 0x2::balance::Balance<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::r1e<T0>(arg0);
    }

    public(friend) fun w0m<T0>() : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::m4n<T0>()
    }

    public(friend) fun w0p(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y7f(arg0, arg1, arg2);
    }

    public(friend) fun w1c(arg0: &0x2::clock::Clock) : u64 {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::b7m(arg0)
    }

    public(friend) fun w1p<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::x9a<T0>(arg0, arg1, arg2)
    }

    public(friend) fun w9p<T0, T1>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::s2f<T0, T1>(arg0)
    }

    public(friend) fun x2x(arg0: address) : address {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::l0v(arg0)
    }

    public(friend) fun x7b<T0, T1>(arg0: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::s2f<T0, T1>(arg0)
    }

    public(friend) fun y5o(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::b9x(arg0, arg1, arg2)
    }

    public(friend) fun y8a<T0>() : 0x2::balance::Balance<T0> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::m4n<T0>()
    }

    public(friend) fun z1g<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::n2p<T0, T1>(arg0, arg1, arg2)
    }

    public(friend) fun z3l<T0: store + key>(arg0: T0, arg1: address) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::p8f<T0>(arg0, arg1);
    }

    public(friend) fun z5y<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, u64) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::u::x9a<T0>(arg0, arg1, arg2)
    }

    public(friend) fun z8c<T0>(arg0: &mut 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::V, arg1: 0x2::coin::Coin<T0>, arg2: 0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::R2<T0>) {
        0x25adbb7426c02b5fb293d2b70bc88e4251918ff6c669903020a68e0797ca435c::r::y4s<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

